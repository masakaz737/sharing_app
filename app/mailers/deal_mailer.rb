class DealMailer < ApplicationMailer
  default from: 'sharing_app@example.com'

  def send_when_approve(deal)
    @deal = deal
    mail(
      subject: 'リクエスト承認メール',
      to: @deal.borrower.email,
    )
  end
end
