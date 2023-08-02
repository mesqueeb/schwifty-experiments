let dbPortfolios = Collection<Portfolio>(fetchFn: { [
  Portfolio(username: "Michael", cv: [CvEntry(year: 2018, month: 12, description: "Hearts Beat Loud"), CvEntry(year: 2016, month: 9, description: "The Good Place")]),
  Portfolio(username: "Eleanor", cv: [CvEntry(year: 2019, month: 3, description: "Frozen II"), CvEntry(year: 2016, month: 9, description: "The Good Place")]),
  Portfolio(username: "Chidi", cv: [CvEntry(year: 2016, month: 9, description: "The Good Place")]),
] })
