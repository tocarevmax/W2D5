class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash

    # [1,2,3] # => 67669591740810512288
    # 11204668313524803552|24041231507019438048|32423691920266270688

    # [3, 2, 1] # => 37669591740810512288
    # 12423691920266270688 + 24041231507019438048 + 1204668313524803552

    # [1,2,4] # => 39223250181908078777
    # 11204668313524803552 + 24041231507019438048 + 3977350361363837177

    # ["a", 1, 2]
    result = 0
    self.each_with_index do |el, idx|
      hashed_el = el.hash
      if hashed_el < 0
        str_with_idx = hashed_el.to_s
          .insert(1,(idx+1).to_s)
      else
        str_with_idx = hashed_el.to_s
          .insert(0,(idx+1).to_s)
      end
      result += str_with_idx.to_i

    end
    result
  end
end


class String
  def hash
    ascii_arr = self.chars.map! { |e| e = e.ord }
    ascii_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash

    # {a: 1, b: 2} == {b: 2, a: 1}
    sum = 0
    self.each do |key, value|
      sum += value.hash + key.hash
    end
    sum
  end
end
