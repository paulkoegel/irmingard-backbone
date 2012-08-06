'use strict'

class IG.Views.ColumnsShow extends Backbone.Marionette.CollectionView
  tagName: 'ul'
  className: 'column'
  itemView: IG.Views.CardsShow
