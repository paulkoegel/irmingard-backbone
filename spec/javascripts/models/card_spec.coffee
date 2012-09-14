describe 'Card', ->
  card = new IG.Models.Card()

  describe 'colour', ->
    suits = ['diamonds', 'hearts', 'clubs', 'spades']
    expectedColours = ['red', 'red', 'black', 'black']
    
    _.each suits, (suit, index) ->
      describe suit, ->
        beforeEach ->
          card.set 'suit', suit
        describe 'colour', ->
          it "should be #{expectedColours[index]}", ->
            expect(card.colour()).toEqual expectedColours[index]
