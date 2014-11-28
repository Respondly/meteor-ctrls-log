###
Provides a read/write handle to a log item.
This allows a log item to be updated after it has been initially added.
###
Handle = stampit().enclose ->
  hash = new ReactiveHash(onlyOnChange:true)
  ctrl = null
  initialState = null


  # ----------------------------------------------------------------------


  ###
  Initializes the handle.
  @param itemCtrl: The { c-log-item } Ctrl that is being controlled.
  ###
  @init = (itemCtrl) ->
    throw new Error('Log item Ctrl not specified.') unless itemCtrl?
    ctrl = itemCtrl
    ctrl.onDestroyed => @dispose()

    # Keep the item in sync.
    @autorun =>
        ctrl.title(@title())

    # Finish up.
    if state = initialState
      @write(state.value, state.options)
      initialState = null


  ###
  Gets or sets the title on the item.
  ###
  @title = (value) -> hash.prop 'title', value


  ###
  Gets or sets the log value.
  @param value    The value.
  @param options: Optional. The options for the value.
  ###
  @write = (value, options) ->
    return undefined if @isDisposed
    if ctrl?
      ctrl.write(value, options)
    else
      # The handle has not been initialized with a Ctrl yet.
      # Store the initial state to load.
      initialState =
        value: value
        options: options
      value




  ###
  Disposes of the log entry.
  ###
  @dispose = ->
    @autorun.dispose
    ctrl?.dispose()
    hash.dispose()
    @isDisposed = true


  # ----------------------------------------------------------------------
  return @






LogHandle = stampit.compose(
  Stamps.AutoRun,
  Handle
)



