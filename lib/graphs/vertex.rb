require_relative "edge"
class Vertex
  attr_accessor :edges, :name

  def initialize(name)
    @edges = {}
    @name = name
  end

  def add_edge(start, finish, weight)
    @edges[finish.name] = Edge.new(start, finish, weight)
  end

  def neighbors
    neighboring_vertices = []
    @edges.each {|end_vertex, edge| neighboring_vertices << edge.finish}
    neighboring_vertices
  end

end
