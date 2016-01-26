def convert_to_bgn(price, currency)
  rate = if currency == :usd
    1.7408
  elsif currency == :eur
    1.9557
  elsif currency == :gbp
   2.6415
  else
    1
  end

  (price*rate).round(2)
end

def compare_prices(price_1, currency_1, price_2, currency_2)
  convert_to_bgn(price_1, currency_1) <=> convert_to_bgn(price_2, currency_2)
end
