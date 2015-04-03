require "graphs/graph"


describe Graph do
  subject(:graph) {Graph.new}

  before(:each) do
    ('a'..'h').each {|name| graph.add_vertex(name)}
    graph.add_edge("a", "b", 2)
    graph.add_edge("a", "c", 1)
    graph.add_edge("b", "d", 3)
    graph.add_edge("b", "e", 4)
    graph.add_edge("c", "e", 3)
    graph.add_edge("c", "g", 5)
    graph.add_edge("c", "h", 10)
    graph.add_edge("d", "f", 3)
    graph.add_edge("e", "f", 2)
    graph.add_edge("e", "g", 3)
    graph.add_edge("f", "g", 2)
    graph.add_edge("g", "h", 2)
  end

  describe "#add_vertex" do
    it "adds vertices to the graph" do
      vertices = graph.vertices
      ('a'..'h').each do |vertex|
        expect(vertices[vertex].class.name).to eq("Vertex")
      end
    end
    it "doesn't add any other vertices" do
      vertices = graph.instance_variable_get(:@vertices)
      ('i'..'z').each {|vertex| expect(vertices[vertex]).to be_nil}
    end
  end

  describe "#add_edge" do
    it "adds edges to each vertex" do
      vertices = graph.instance_variable_get(:@vertices)
      expect(vertices["a"].edges["b"].weight).to eq(2)
      expect(vertices["a"].edges["c"].weight).to eq(1)
      expect(vertices["b"].edges["d"].weight).to eq(3)
      expect(vertices["b"].edges["e"].weight).to eq(4)
      expect(vertices["c"].edges["e"].weight).to eq(3)
      expect(vertices["c"].edges["g"].weight).to eq(5)
      expect(vertices["c"].edges["h"].weight).to eq(10)
      expect(vertices["d"].edges["f"].weight).to eq(3)
      expect(vertices["e"].edges["f"].weight).to eq(2)
      expect(vertices["e"].edges["g"].weight).to eq(3)
      expect(vertices["f"].edges["g"].weight).to eq(2)
      expect(vertices["g"].edges["h"].weight).to eq(2)
    end
  end
end
