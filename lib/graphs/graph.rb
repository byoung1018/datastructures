require_relative "vertex"

class Graph
  attr_accessor :vertices
  def initialize
    @vertices = {}
  end


  def add_vertex(name)
    @vertices[name] = Vertex.new
  end

  def add_edge(start, finish, weight)
    @vertices[start].add_edge(start, finish, weight)
  end



end
