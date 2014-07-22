class Graph
  constructor: ->
    # Set elements
    @graphs = ($ '.graph')
    @form = ($ 'form')
    # Loop and setup the graphs
    @retrieveData(graph) for graph in @graphs
    # Listen to changes
    @bindListeners()

  # Build JSON from data, returns hash
  initializeData: (data) =>
    # Set data array
    new_data = []
    # Loop through data en create correct array
    for row in data
      # Append into array with new format
      new_data.push {'m': moment(row['m']).format('DD-MM-YYYY') , "a": row["a"] }
    # Return array
    return new_data

  # Retrieve data
  retrieveData: (graph) =>
    url = ($ graph).attr('data-url')
    # Get values via graph url as AJAX request
    $.ajax url,
      type: 'GET'
      dataType: 'json'
      success: (data, textStatus, jqXHR) =>
        # Parse data and build graph
        @buildGraph(graph, @initializeData(data))

  bindListeners: =>
    @form.on 'submit', (e) =>
      # Check which changed and set graph ID
      if ($ e.target).hasClass('smokes')
        renew_graph = ($ '#graph-smokes')
      else
        renew_graph = ($ '#graph-sports')
      # Refresh after a time
      setTimeout =>
        @retrieveData(renew_graph)
      , 200

  buildGraph: (graph, data) =>
    # Set correct label
    if ($ graph).hasClass('smokes')
      lable_title = ["Sigaretten"]
      color       = ["#ee4d21"]
    else
      lable_title = ["Calorieën"]
      color       = ["#a2d04c"]
    # Remove graph
    ($ graph).empty()
    # Build graph
    Morris.Area({
      "fillOpacity": "0.6",
      "lineColors": color,
      "resize": true,
      "xLabels": "day",
      "element": ($ graph).attr('id'),
      "data": data,
      "xkey": "m",
      "ykeys": "a",
      "labels": lable_title,
      "parseTime": false
    })

$ ->
  remover = new Graph if ('.graph').length > 0
