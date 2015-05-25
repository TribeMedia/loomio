describe 'Discussions Card Component', ->

  beforeEach module 'loomioApp'
  beforeEach useFactory

  beforeEach inject ($httpBackend) ->
    $httpBackend.whenGET(/api\/v1\/translations/).respond(200, {})
    $httpBackend.whenGET(/api\/v1\/discussions/).respond(200, {})

  it 'passes the group', ->
    prepareDirective @, 'discussions_card', { group: 'group' }, (parent) =>
      parent.group = @factory.create 'groups', name: 'groupadoop'
    expect(@$scope.group.name).toBe('groupadoop')
