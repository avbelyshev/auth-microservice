channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)

  token = payload['token']
  result = AuthService.call(token)

  user_id = result.present? ? result.user_id : ''

  if user_id.present?
    Application.logger.info(
      'Verified token',
      token: token,
      user_id: user_id
    )
  else
    Application.logger.warn('User not found', token: token)
  end

  exchange.publish(
    user_id.to_s,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id,
    headers: {
      request_id: Thread.current[:request_id]
    }
  )
end
