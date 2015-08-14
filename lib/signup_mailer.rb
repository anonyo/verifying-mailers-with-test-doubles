class SignupMailer
  attr_reader :subject

  def initialize(account:, user:)
    @account = account
    @user = user
    @subject = "Your new #{@account.name} account"
  end

  def self.signup(account:, user:)
    new(account: account, user: user)
  end

  def deliver
  end
end
