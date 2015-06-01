require 'sunstore'

describe "Sunstore" do

  def clear_all
    # Force everything to clear!  
    Sunstore::Store.reset
    if File.exist? Sunstore::Store.instance.store_file then  File.delete(Sunstore::Store.instance.store_file)  ; end
  end

  def clear_data
    # puts "Clearing data"
    Sunstore.clear
    # if File.exist? Sunstore::Store.instance.store_file then  File.delete(Sunstore::Store.instance.store_file)  ; end    
  end

  before :context do 
    clear_all
  end

  describe "Reset behavior" do
    it "should work by clearing everything" do
      Sunstore.put("foo","baz")
      expect(File.size(Sunstore::Store.instance.store_file)).to be > 0 
      Sunstore.clear
      # There should be no content, just the standard yaml stuff
      expect(File.read(Sunstore::Store.instance.store_file)).to match(/^[-{}\s]+$/m)
    end
  end

  describe "Default behaviour" do
    it "should create a yaml file by default" do
      expect(Sunstore::Store.instance.store_file[-4..-1]).to eq("yaml")
      Sunstore.put("foo","bar")
      expect(File.exist?(Sunstore::Store.instance.store_file)).to be true
    end
  end

  describe "Config behavior" do
    before :each do
      clear_all
    end

    it "should allow filename to be changed" do
      Sunstore.config(basename: "foo")
      expect(Sunstore::Store.instance.store_file).to match(/foo.yaml$/)
    end  

    it "should allow default location to change" do
      Sunstore.config(basename: "foo", basedir: File.join(Dir.getwd,"tmp"))
      expect(Sunstore::Store.instance.store_file).to match(%r{tmp/foo.yaml$})
    end

    it "should allow format to change" do
      Sunstore.config(basename: "foo", basedir: File.join(Dir.getwd,"tmp"),format: :json)
      expect(Sunstore::Store.instance.store_file).to match(%r{tmp/foo.json$})      
    end

    it "should reject formats that are not supported" do
      expect { Sunstore.config(format: :foo) }.to raise_error(RuntimeError)
    end
  end

  describe "Yaml behavior" do
    before :context do 
      Sunstore.config(format: :yaml)
    end

    before :each do 
      clear_data
    end

    it "should be able to save and restore a simple hash" do
      Sunstore.put("foo","baz")
      expect(File.size(Sunstore::Store.instance.store_file)).to be > 0 
      v = Sunstore.get("foo")
      expect(v).to eq("baz")
    end

    it "should be able save multiple items" do
      Sunstore.put("a",2)
      Sunstore.put("b","test")
      expect(Sunstore.get("a")).to eq(2)
      expect(Sunstore.get("b")).to eq("test")
    end

    it "should be able to delete a value" do
      Sunstore.put("a",2)
      expect(Sunstore.get("a")).to eq(2)
      Sunstore.delete("a")      
      expect(Sunstore.get("a")).to be nil
      expect(Sunstore.keys.size).to eq 0
    end

    it "should be able to save complex structures" do 
      x = {x: 10, y:"test"}
      Sunstore.put("x",x)
      expect(Sunstore.get("x")).to eq(x)
      y = ["test",22.4,{x: [1,2,3],y:{f:20,z:"test"}}]
      Sunstore.put("y",y)
      expect(Sunstore.get("y")).to eq(y)
      expect(Sunstore.keys.size).to be 2
    end

    describe "JSON handling" do
      before :context do 
        Sunstore.config(format: :json)
      end

      before :each do 
        clear_data
      end
      
      it "should create a json file when specified" do
        expect(Sunstore::Store.instance.store_file[-4..-1]).to eq("json")
        Sunstore.put("foo","bar")
        expect(File.exist?(Sunstore::Store.instance.store_file)).to be true
      end

      it "should be able to save and restore a simple hash" do
        Sunstore.put("foo","baz")
        expect(File.size(Sunstore::Store.instance.store_file)).to be > 0 
        v = Sunstore.get("foo")
        expect(v).to eq("baz")
      end

      it "should be able save multiple items" do
       Sunstore.put("a",2)
       Sunstore.put("b","test")
       expect(Sunstore.get("a")).to eq(2)
       expect(Sunstore.get("b")).to eq("test")
      end

      it "should be able to delete a value" do
       Sunstore.put("a",2)
       expect(Sunstore.get("a")).to eq(2)
       Sunstore.delete("a")      
       expect(Sunstore.get("a")).to be nil
       expect(Sunstore.keys.size).to eq 0
      end

      it "should be able to save complex structures" do 
       x = {x: 10, y:"test"}
       Sunstore.put("x",x)
       expect(Sunstore.get("x")).to eq(x)
       y = ["test",22.4,{x: [1,2,3],y:{f:20,z:"test"}}]
       Sunstore.put("y",y)
       expect(Sunstore.get("y")).to eq(y)
       expect(Sunstore.keys.size).to be 2
      end
     
    end
  end
end