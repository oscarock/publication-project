module PublicationsHelper

  def date_format(date)
    meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
    mes = meses[date.strftime("%-m").to_i - 1]
    dia = date.strftime("%d")
    year = date.strftime("%Y")

    "#{dia} de #{mes} de #{year}"
  end
end
