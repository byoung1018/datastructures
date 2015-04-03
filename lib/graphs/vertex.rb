require_relative "edge"
class Vertex
  attr_accessor :edges

  def initialize()
    @edges = {}
  end

  def add_edge(start, finish, weight)
    @edges[finish] = Edge.new(start, finish, weight)
  end

end
