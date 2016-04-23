class Quote < ActiveRecord::Base
  def to_s
    "<h4 style=\"color:blue;\"><q>#{body}</q> <small>#{author}</small></h4>".html_safe
  end

  def self.random(_the_count = 1)
    order('RAND()').first
  end
end
