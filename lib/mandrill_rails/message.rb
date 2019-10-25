module Mail
  class Message
    attr_accessor :mandrill_template,
                  :mandrill_merge_vars,
                  :mandrill_template_content

    def mandrill_template(template = nil)
      if template
        @mandrill_template = template
      else
        @mandrill_template
      end
    end

    def mandrill_merge_vars(vars = nil)
      if vars
        @mandrill_merge_vars = vars
      else
        @mandrill_merge_vars || {}
      end
    end

    def mandrill_template_content(content = nil)
      if content
        @mandrill_template_content = content
      else
        @mandrill_template_content || []
      end
    end
  end
end
