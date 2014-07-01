class Graph
  constructor: ->
    # Set elements
    @graphs = ($ 'canvas')
    @form = ($ 'form')

    # Set initial data
    @data = {
      "labels": ["V1","V2","V3","V4", "V5", "V6", "V7"],
      "datasets": [
          {
            "data": [105,1234,103412,15]
          }
      ]
    }

    # On form submit, reload graphs
    # @form.on 'load', (e) =>
    for graph in @graphs
      console.log "IN DE LOOP"
      # Set graph element
      graphic = ($ graph)
      id = graphic.attr('id')
      # Get reload url
      console.log graph_url = graphic.attr('data-url')

      # Create new (responsive) chart
      respChart($("##{id}"),@data);

$ ->
  remover = new Graph
