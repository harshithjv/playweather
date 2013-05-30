define [
  'underscore'
  'store_original'
], (_, store) ->

  _.extend store,
    setOriginal: store.set
    getOriginal: store.get

  _.extend store,

    set: (key, val, exp = undefined) ->
      if exp?
        @setOriginal key,
          time: new Date().getTime()
          exp: exp
          val: val
      else
        @setOriginal key, val

    get: (key) ->
      info = @getOriginal key
      if _.isObject(info) and info.exp? and info.time?
        if info.exp >= new Date().getTime() - info.time
          info.val
        else
          @remove key
          null
      else
        info

  store
