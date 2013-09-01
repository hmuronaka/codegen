# coding: utf-8

module Codegen

  module IniCommentGenerator
  
    def comment_to_s(comment)
      comment ? comment.gsub(/^/, ";") : ""
    end
  
  end
  
end
