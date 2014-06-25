class refreshGraph
  constructor: ->
    @graphs = ($ '.graph')

    # for graph in @graphs
      # @checkForChanges(graph)

  checkForChanges: (graph) ->
    graph_url = ($ graph).attr('data-url')
    # Check every 5 seconds
    setInterval ( -> ($ graph).load(graph_url)), 1000

$ ->
  refres_graph = new refreshGraph if ($ '.graph').length > 0
