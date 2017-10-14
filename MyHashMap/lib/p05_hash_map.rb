require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def [](key)
    get(key)
  end

  def []=(key, value)
    set(key, value)
  end

  def include?(key)
    bucket(key).find(key)
  end

  #[LL],[LL],[LL],[LL],[LL],[LL],[LL],[LL]

  def set(key, val)
    resize! if @count + 1 > num_buckets
    cur_bucket_ll = bucket(key)
    if cur_bucket_ll.include?(key)
      cur_bucket_ll.update(key,val)
    else
      @count += 1
      cur_bucket_ll.append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    cur_bucket_ll = bucket(key)
    if cur_bucket_ll.include?(key)
      cur_bucket_ll.remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |k, v|
        prc.call(k, v)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    temp_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    temp_store.each do |linked_list|
      linked_list.each do |k, v|
        set(k, v)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
