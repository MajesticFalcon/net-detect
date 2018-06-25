class String
  def padd(size, padstr=' ')
    self[0...size].ljust(size, padstr) #or ljust
  end
end
