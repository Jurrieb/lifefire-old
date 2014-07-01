class Graph
  constructor: ->
    # Set elements
    @graphs = ($ 'canvas')
    @form = ($ 'form')
    # Loop and setup the graphs
    @initializeGraphs(graph) for graph in @graphs
    # Listen to changes
    @bindListeners()

  # Build JSON from data, returns hash
  initializeData: (data) ->
    # Build empty hash
    json_data = {"labels": [], "datasets": []}
    dataset = {"data": []}

    # Loop through data en create correct hash
    for date, value of data
      # Append to label array date, and parse
      json_data['labels'].push new Date(date).strftime('%Y-%m-%d')
      # Create array values
      dataset['data'].push value

    # Join dataset with datasets
    json_data['datasets'].push dataset

    # Return object
    return json_data

  # Build the graph
  initializeGraphs: (graph) =>
    # Create object and get ID and url
    graphic   = ($ graph)
    id        = graphic.attr('id')
    graph_url = graphic.attr('data-url')

    # Get values via graph url as AJAX request
    $.ajax graph_url,
      type: 'GET'
      dataType: 'json'
      success: (data, textStatus, jqXHR) =>
        data = @initializeData(data)

        # # Replace text and numbers
        # date_in_view = new Date(data['date'])
        # # Set date localisation
        # date_in_view.locale = "nl"
        # # Set in view
        # @date_in_text.text(date_in_view.strftime('%d %B'))

        # Create new (responsive) chart
        respChart(($ "##{id}"), data);


  # Refresh Graphs
  bindListeners: =>
    @form.on 'change', (e) =>
      @initializeGraphs(graph) for graph in @graphs

$ ->
  remover = new Graph if ($ 'canvas').length > 0
