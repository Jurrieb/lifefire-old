class refreshGraph
  constructor: ->
    
    @graphs = ($ '.graph')
    @form = ($ 'form')

    # On form change, reload graphs
    @form.on 'change', (e) =>
      for graph in @graphs
        # Set graph element
        graphic = ($ graph)
        # Get reload url
        graph_url = graphic.attr('data-url')
        # Reload graph based on ID
        if graphic.has('#chart-smokes')
          id = 'chart-smokes'
        else
          id = 'chart-sports'
        # Create new chart
        new Chartkick.AreaChart(id, graph_url)

$ ->
  refresh_graph = new refreshGraph if ($ '.graph').length > 0
