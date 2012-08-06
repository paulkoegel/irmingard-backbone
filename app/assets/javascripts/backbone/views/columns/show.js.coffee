'use strict'

class IG.Views.ColumnsShow extends Backbone.Marionette.CollectionView
  tagName: 'ul'
  class: 'column'
  itemView: IG.Views.CardsShow
