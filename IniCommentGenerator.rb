# coding: utf-8

module Codegen

  module IniCommentGenerator
  
    def generate_comment(comment)
      comment ? comment.gsub(/^/, ";") : ""
    end
  
  end
  
end
