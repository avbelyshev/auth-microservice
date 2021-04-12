channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)

  result = AuthService.call(payload['token'])

  user_id = result.present? ? result.user_id : ''

  exchange.publish(
    user_id.to_s,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )
end
