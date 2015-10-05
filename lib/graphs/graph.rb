require_relative "vertex"
require "byebug"

class Graph
  attr_accessor :vertices
  def initialize
    @vertices = {}
  end


  def add_vertex(name)
    @vertices[name] = Vertex.new(name)
  end

  def add_edge(start, finish, weight)
    add_vertex(start) unless @vertices[start]
    add_vertex(finish) unless @vertices[finish]
    @vertices[start].add_edge(@vertices[start], @vertices[finish], weight)
  end

  def dijkstra(start, finish)
    #initialization - create hash of vertices/distances and visited vertexs
    vertex_distances = {}
    vertex_distances[start.name] = 0
    current_vertex = start
    unvisited = [start] #will use min heap once I make one
    visited = {}

    until unvisited.empty?
      return vertex_distances[current_vertex.name] if current_vertex == finish
      current_vertex.edges.each do |edge_finish, edge|
        new_distance = vertex_distances[current_vertex.name] + edge.weight
        neighbor = edge.finish
        old_distance = vertex_distances[neighbor.name]
        if old_distance && old_distance > new_distance || !old_distance
          vertex_distances[neighbor.name] = new_distance
        end
        unvisited << neighbor unless visited[neighbor]
        visited[current_vertex] = true
      end
      unvisited.delete(current_vertex)
      current_vertex = unvisited.min_by {|vertex| vertex_distances[vertex.name]}
    end

    nil
  end

end
