should = require 'should'

describe 'simple extension', ->
  schema = """
    extension foo-ext {
      description "A simple extension";
      argument "name";
    }
  """

  it "should parse simple extension statement", ->
    y = Yang.parse schema
    y.should.have.property('tag').and.equal('foo-ext')
    y.should.have.property('kind').and.equal('extension')

describe 'extended extension', ->
  schema = """
  module foo {
    extension c-define {
      description
        "Takes as argument a name string.
        Makes the code generator use the given name in the
        #define.";
      argument "name";
    }
    container interfaces {
      c-define "MY_INTERFACES";
    }
  }
  """

  it "should parse use of extension statement", ->
    y = Yang.parse schema
    y.should.have.property('tag').and.equal('foo')

describe 'imported extension', ->
  imported_schema = """
  module foo2 {
    extension c-define {
      description
        "Takes as argument a name string.
        Makes the code generator use the given name in the
        #define.";
      argument "name";
    }
  }
  """
  schema= """
  module bar {
    import foo2 {
      prefix foo;
    }
    container interfaces {
      foo:c-define "MY_INTERFACES";
    }
  }
  """
  it "should parse imported extension", ->
    y1 = Yang.use (Yang.parse imported_schema)
    y2 = Yang.parse schema
    y2.should.have.property('tag').and.equal('bar')

