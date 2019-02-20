<template>
  <v-list two-line>
    <template v-for="(msg, i) in msgs">
      <v-list-tile>
        <v-list-tile-avatar>
          <v-icon class="grey white--text">event_note</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title v-html="title(msg)" />
          <v-list-tile-sub-title v-html="subtitle(msg)" />
        </v-list-tile-content>
        <v-list-tile-action>
          <v-btn icon ripple :href="msg.link" target="_blank">
            <v-icon class="grey white--text">link</v-icon>
          </v-btn>
        </v-list-tile-action>
      </v-list-tile>
    </template>
  </v-list>
</template>

<script lang='coffee'>
{eventBus} = require('jsOAuth2/frontend/src/lib').default

export default
  data: ->
    msgs: []
  methods:
    title: (msg) ->
      "<span class='text--primary'>#{msg.code} #{msg.name}</span> #{msg.type} #{msg.typeDetail}"
    subtitle: (msg) ->
      "<span class='text--primary'>#{msg.title}</span> #{new Date(msg.releasedAt).toLocaleString()}"
  created: ->
    eventBus.$on 'hkex', (msg) =>
      data = JSON.parse msg.toString()
      data.link = process.env.HKEXURL + data.link
      @msgs.unshift data
</script>
