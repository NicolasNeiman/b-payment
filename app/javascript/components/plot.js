const plot = () => {
  const plotDiv = document.getElementById('plot');
  if (plotDiv) {
    Chartkick.use(Chart)
    const selector = 'chart-1'
    const data = document.querySelector(`#${selector}`).dataset
    const rawData = JSON.parse(data.payload)
    const yMin = data.ymin
    const yMax = data.ymax
    new Chartkick.LineChart( selector, rawData,
      {
        points: false,
        colors: ["#000", "#666"],
        thousands: " ",
        decimal: ",",
        suffix: "€",
        min: yMin,
        max: yMax,
        label: "BTC-EUR",
        xAxes: [{
          gridLines: {
            display: false,
          },
        }],
      }
    )
  }
}

export { plot }