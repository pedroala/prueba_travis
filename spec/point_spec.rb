require "spec_helper"


RSpec.describe Point do
  it "has a version number" do
    expect(Point::VERSION).not_to be nil
  end

  context "# almacenamiento de las coordenadas" do
    it "Se almacena correctamente la coordenada X" do
      p0 = Point::Point.new(2,2)
      p1 = Point::Point.new(1,1)
      expect(p1.x).to eq(1)
    end
    it "Se almacena correctamente la coordenada Y" do
      p1 = Point::Point.new(1,1)
      expect(p1.y).to eq(1)
    end
  end # context


  context "# herencia" do
    before :each do
      @p1 = Point::Point.new(1,1)
    end    
    
    it "un objeto punto es una instancia de la clase Point" do
       expect(@p1).to be_an_instance_of(Point::Point) # =>@p1.instance_of?(Point) # passes
    end

    it "un objeto punto no es una instancia de la clase Object" do
       expect(@p1).not_to be_an_instance_of(Object) # =>@p1.instance_of?(Object) # fails
    end

    it "un objeto punto no es una instancia de la clase BasicObject" do
       expect(@p1).not_to be_an_instance_of(BasicObject) # =>@p1.instance_of?(BasicObject) # fails
    end

    it "un punto es un Point" do
       expect(@p1).to be_a_kind_of(Point::Point) # =>@p1.kind_of?(Point) # passes
    end

    it "un punto es un Object" do
       expect(@p1).to be_a_kind_of(Object) # =>@p1.kind_of?(Object) # passes
    end

    it "un punto es un BasicObject" do
       expect(@p1).to be_a_kind_of(BasicObject) # =>@p1.kind_of?(BasicObject) # passes
    end
  end

  context "# tipo" do
    before :each do
      @p1 = Point::Point.new(1,1)
    end    
    
    it "un objeto punto responde al método x" do
       expect(@p1).to respond_to(:x) # pass if @p1.respond_to?(:x)
    end

    it "un objeto punto responde al método y" do
       expect(@p1).to respond_to(:y) # pass if @p1.respond_to?(:y)
    end

    it "un objeto punto responde a los métodos x e y" do
       expect(@p1).to respond_to(:x, :y) # pass if @p1.respond_to?(:x) &&@ p1.respond_to(:y)
    end

    it "un objeto punto responde al método +" do
       expect(@p1).to respond_to('+') # pass if @p1.respond_to?('+') 
    end

    it "un objeto punto responde al método + con un argumento" do
       expect(@p1).to respond_to('+').with(1).arguments 
    end
    
  end
 
  context "# producto por un escalar" do
    before :each do
      @p1 = Point::Point.new(1,1)
    end    
    
    it "la coordenada x y la coordenada y se multiplican por el valor" do
      p2 = @p1*5 
      expect(p2.x).to eq(5)
      expect(p2.y).to eq(5)
    end
    it "Si se multiplica por -1 se obtiene el opuesto" do
      p2 = @p1*-1 
      expect(p2.x).to eq(-1)
      expect(p2.y).to eq(-1)
    end
  end
  
  context "# opuesto de un punto" do
    it "la coordenada x y la coordenada y se multiplican por menos uno" do
      p1 = Point::Point.new(1,1)
      p2 = - p1 
      expect(p2.x).to eq(-1)
      expect(p2.y).to eq(-1)
    end
  end
  
  context "# suma de dos puntos " do
    it "coordenada x = original.x + otro.x, coordenada y = original.y + otro.y " do
      p1 = Point::Point.new(1,1) 
      p2 = p1 + p1
      expect(p2.x).to eq(2)
      expect(p2.y).to eq(2)
    end
  end
  
  context "# comparaciones entre dos puntos basada en su distancia al origen" do
    before :each do
       @p1 = Point::Point.new(1,1)
       @p2 = Point::Point.new(2,2)
       @p3 = Point::Point.new(1,0)
       @p4 = Point::Point.new(0,1)
       @pm = Point::Point.new(false,nil)
    end
    it "El punto (1,1) es menor que el punto (2,2)" do
      expect(@p1 < @p2).to eq(true)
    end
    it "El punto (1,1) es menor o igual que el punto (2,2)" do
      expect(@p1 <= @p2).to eq(true)
    end
    it "El punto (2,2) es mayor que el punto (1,1)" do
      expect(@p2 > @p1).to eq(true)
    end
    it "El punto (2,2) es mayor o igual que el punto (1,1)" do
      expect(@p2 >= @p1).to eq(true)
    end

    it "El punto (1,1) es igual al punto (1,1)" do
      expect(@p1 == @p1).to eq(true)
    end

    it "El punto (1,0) y el punto (0,1) son distintos" do
      expect(@p3 == @p4).to eq(false)
    end

    it "El punto (1,1) es distinto del Rectangulo (1,1)" do
      Rectangle = Struct.new(:x, :y)
      r = Rectangle.new(1,1)
      expect(@p1 == r).to eq(false)
    end
    
  end # context

 context "# haciendo el punto enumerable" do
    before :each do
       @p1 = Point::Point.new(1,1)
       @p2 = Point::Point.new(2,2)
       @p3 = Point::Point.new(1,0)
       @p4 = Point::Point.new(0,1)
       @pm = Point::Point.new(false,nil)
    end
    it "comprobrando el metodo all? con un bloque vacio" do
      expect(@p1.all?).to eq(true)
      expect(@pm.all?).to eq(false)
    end 
    it "comprobrando el metodo any?" do
      expect(@p1.any?).to eq(true)
      expect(@pm.any?).to eq(false)
    end 
    it "comprobrando el metodo collect" do
      expect(@p2.map{|i| i*i}).to eq([4,4])
      expect(@p2.collect{|i| i*i}).to eq([4,4])
    end 
    it "comprobrando el metodo count" do
      expect(@p2.count).to eq(2)
    end
    it "comprobrando el metodo detect" do
      expect(@p3.detect {|i| i == 0}).to eq(0)
      expect(@p3.find {|i| i == 1}).to eq(1)
    end
    it "comprobrando drop" do
      expect(@p4.drop(1)).to eq([1])
    end
    it "comprobrando max" do
      expect(@p4.max).to eq(1)
    end
    it "comprobrando min" do
      expect(@p4.min).to eq(0)
    end
    it "comprobrando sort" do
      expect(@p3.sort).to eq([0,1])
    end
  end
  
end # describe
