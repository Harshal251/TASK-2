module Payments
require('stripe')

Stripe.api_key = 'sk_test_51LdETHSG5cMn4qG8APZiGmsAjL5n8oS2CblLoLfCn3XGbPGgPiv3SKEKsrG2PqoOuL9VPHGjjUUD6KaaV6GhaetY005A1NPTzC'

# print('Enter price: ')
pp = @slot.price

price = Stripe::Price.create({
                               unit_amount: pp,
                               currency: 'inr',
                               product: 'prod_MM084bx0fPh0oK'
                             })

order = Stripe::PaymentLink.create(
  line_items: [{ price: price.id, quantity: 1 }],
  after_completion: { type: 'redirect', redirect: { url: 'https://dashboard.stripe.com/test/payments/pi_3LdIZ8SG5cMn4qG808CaaGia' } }
)
system('xdg-open', order.url)
end
