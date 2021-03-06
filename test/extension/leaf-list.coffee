describe 'simple schema', ->
  schema = 'leaf-list foo;'

  it "should parse simple leaf-list statement", ->
    y = Yang.parse schema
    y.should.have.property('tag').and.equal('foo')

  it "should create simple leaf-list element", ->
    o = (Yang schema) foo: [ 'hello' ]
    o.should.have.property('foo').and.be.instanceOf(Array)
    o.foo.should.have.length(1)
    o.foo[0].should.equal('hello')

  it "should allow setting a new leaf-list", ->
    o = (Yang schema)()
    o.foo = [ 'hello', 'world' ]
    o.foo.should.be.instanceOf(Array).and.have.length(2)

describe 'extended schema', ->
  schema = """
    leaf-list foo {
      description "extended leaf-list foo";
      min-elements 1;
      max-elements 5;
    }
    """
  it "should parse extended leaf-list statement", ->
    y = Yang.parse schema
    y['min-elements'].should.have.property('tag').and.equal(1)
    y['max-elements'].should.have.property('tag').and.equal(5)

  it "should create extended leaf-list element", ->
    o = (Yang schema) foo: [ 'hello' ]
    o.foo.should.be.instanceOf(Array).and.have.length(1)

  it "should validate min/max elements constraint", ->
    o = (Yang schema) foo: [ 'hello' ]
    (-> o.foo = []).should.throw()
    (-> o.foo = [ 1, 2, 3, 4, 5, 6 ]).should.throw()
    (-> o.foo = [ 1, 2, 3, 4, 5 ]).should.not.throw()

  it.skip "should support order-by condition", ->

describe 'typed schema', ->
  schema = """
    leaf-list foo {
      type string;
    }
    """
  it "should parse type extended leaf-list statement", ->
    y = Yang.parse schema
    y.type.should.have.property('tag').and.equal('string')

  it "should create type extended leaf-list element", ->
    o = (Yang schema) foo: []
    o.should.have.property('foo')

