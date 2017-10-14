class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # head: [@key=nil, @value=nil, next = el1, @prev = nil] =>  it is head because it's @prev == nil
      # el1 : [@key, @value, next = el2, @prev = head]  =>
      # el2 : [@key, @value, next = tail, @prev = el1] => remove
    # tail: [@key=nil, @value=nil, next = nil, @prev = el2] it is tail because it's @next == nil
    # optional but useful, connects previous link to next link
    # and removes self from list.

    # head: [@key=nil, @value=nil, next = el1, @prev = nil] =>  it is head because it's @prev == nil
      # el1 : [@key, @value, next = tail, @prev = head]  =>
            # el2 : [@key, @value, next = tail, @prev = el1] => remove
    # tail: [@key=nil, @value=nil, next = nil, @prev = el1] it is tail because it's @next == nil
    # change el1.next = el2.next
    # el2.next.prev = el2.previous
    #
    #el2.remove
    # self = el2

    # head: [@key=nil, @value=nil, next = tail, @prev = nil] =>  it is head because it's @prev == nil
    # tail: [@key=nil, @value=nil, next = nil, @prev = head] it is tail because it's @next == nil

    # head: [@key=nil, @value=nil, next = tail, @prev = nil] =>  it is head because it's @prev == nil
    # el1 [@key=nil, @value=nil, next = tail, @prev = nil]
    # tail: [@key=nil, @value=nil, next = nil, @prev = head] it is tail because it's @next == nil
    # tail.prev = el1
    # head.next = el1
    # el1.prev = head
    # el1.next = tail

    # new_node.next = target_node.next
    # new_node.prev = target_node
    # target_node.next.prev = new_node
    # target_node.next = new_node
    #

    # target_node.next.prev = new_node
    # target_node.next = new_node
    # new_node.prev = target_node

    # new_node.prev = target_node
    # new_node.next = target_node.next

    # node.append => last
    # last = obj || nil
    # if last != nil      (means that it's not an empty linklist) target = last
      # head.next = el1
      # tail.prev = el1
      # el1.prev = head
      # el1.next = tail
    # else                (this means that it is an empty linklist) target = head

      # head.next = el1
      # tail.prev = el1
      # el1.prev = head
      # el1.next = tail
    # end
    @prev.next = @next
    @next.prev = @prev
    @next = false
    @prev = false
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail

  def initialize
    head_tail
  end

  def head_tail
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    nxt = @head.next
    if nxt.next == nil  #it's a tail
      nil
    else
      nxt
    end
  end

  def last
    prv = @tail.prev
    if prv.prev == nil  #it's a head
      nil
    else
      prv
    end
  end

  def empty?
    @head.next == @tail
    # first == nil #|| last == nil
  end

  def get(key)
    return nil if find(key).nil?
    found = find(key)
    found.val
  end

  def include?(key)
    return false if find(key).nil?
    true
  end

  def append(key, val)
    if last != nil  #(means that it's NOT an empty linklist) target = last
      target_node = last
    else            #(this means that it is an empty linklist) target = head
      target_node = @head
    end
    new_node = Node.new(key, val)
    new_node.next = target_node.next
    new_node.prev = target_node
    target_node.next.prev = new_node
    target_node.next = new_node
  end

  def update(key, val)
    # current = @tail
    obj = find(key)
    obj.val = val unless obj == nil
    # current.prev.val = val unless current.prev == nil
  end

  def find(key)
    current = @tail
    until current.prev == nil || current.prev.key == key
      current = current.prev
    end
    unless current.prev == nil
      current.prev
    else
      nil
    end
  end

  def remove(key)
    find(key).remove
  end

  def each(&prc)
    current = @head
    until current == @tail.prev
      current = current.next
      prc.call(current.key, current.val)
    end
  end

def [](idx)
  i = 0
  current = first
  until i == idx
    current = current.next
    i += 1
  end
  current
end
  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
