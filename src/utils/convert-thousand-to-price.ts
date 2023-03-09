export function convertThousandToPrice(price: number) {

  const valueString = price.toString();
  const [reais, centavos] = valueString.split(',').map(Number)

  const valorTotal = (reais + centavos)

 return valorTotal;
}