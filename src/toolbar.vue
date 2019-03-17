<template>
  <v-toolbar color='primary'>
    <v-toolbar-title class='white--text'>
      HKEX mqtt
    </v-toolbar-title>
    <v-spacer />
    <v-text-field
      label='flespi.io token'
      v-model='token'
      solo hide-details single-line />
    <v-btn @click='connect'>Connect</v-btn>
  </v-toolbar>
</template>

<script lang='coffee'>
guid = require 'browserguid'
mqtt = require 'mqtt'
{eventBus} = require('jsOAuth2/frontend/src/lib').default

export default
  data: ->
    token: null
  methods:
    connect: ->
      client = mqtt
        .connect process.env.MQTTURL,
          clientId: guid()
          username: @token
          clean: false
        .on 'connect', ->
          client.subscribe process.env.MQTTTOPIC, qos: 2
          console.info 'connected'
        .on 'message', (topic, msg) ->
          if topic == process.env.MQTTTOPIC
            eventBus.$emit 'hkex', msg
        .on 'error', console.error
</script>
