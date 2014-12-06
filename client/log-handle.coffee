###
Provides a read/write handle to a log item.
This allows a log item to be updated after it has been initially added.
###
LogHandle = stampit().enclose ->
  ctrl = null
  queue = []
  @uid = _.uniqueId('uid')


  processChange = (args) =>
    ctrl[args.method](args.value, args.options)


  queueChange = (method, value, options = {}) =>
    args = { method:method, value:value, options:options }

    isWrite = value isnt undefined
    isWrite = true if value is undefined and options.showUndefined is true

    if isWrite
      if ctrl?
        # Is initialized, process the change immediately.
        processChange(args)
      else
        # Not initializes yet, queue up the operation.
        queue.push(args)

    # Finish up.
    return @ if value isnt undefined # WRITE: Allow method chaining.
    return value # READ.


  # ----------------------------------------------------------------------


  ###
  Initializes the handle.
  @param itemCtrl: The { c-log-item } Ctrl that is being controlled.
  ###
  @init = (itemCtrl) ->
    # Setup initial conditions.
    return if ctrl?
    throw new Error('Log item Ctrl not specified.') unless itemCtrl?

    # Manage Ctrl.
    ctrl = itemCtrl
    ctrl.onDestroyed => @dispose()

    # Set initial state.
    processChange(item) for item in queue


  ###
  Disposes of the log entry.
  ###
  @dispose = ->
    ctrl?.dispose()
    @isDisposed = true
    queue = []


  # ----------------------------------------------------------------------


  ###
  Gets or sets the title on the item.
  ###
  @title = (value) -> queueChange 'title', value


  ###
  Gets or sets the sub-title on the item.
  ###
  @subtitle = (value) -> queueChange 'subtitle', value


  ###
  Gets or sets the value (pass through to the [write] method).
  ###
  @value = (value, options) -> queueChange 'write', value, options

  ###
  Sets the log value.
  @param value    The value.
  @param options: Optional. The options for the value.
  ###
  @write = (value, options = {}) ->
    options.showUndefined = true
    queueChange 'write', value, options
    @ # Write always returns the handle.


  # ----------------------------------------------------------------------
  return @





