RSpec.describe Users::CreateService do
  subject { described_class }

  context 'valid parameters' do
    it 'creates a new user' do
      expect { subject.call('user', 'user@example.com', 'password') }
        .to change { User.count }.from(0).to(1)
    end

    it 'assigns user' do
      result = subject.call('user', 'user@example.com', 'password')

      expect(result.user).to be_kind_of(User)
    end
  end

  context 'invalid parameters' do
    it 'does not create user' do
      expect { subject.call('user', 'user@example.com', '') }
        .not_to change { User.count }
    end

    it 'assigns user' do
      result = subject.call('user', 'user@example.com', '')

      expect(result.user).to be_kind_of(User)
    end
  end
end
