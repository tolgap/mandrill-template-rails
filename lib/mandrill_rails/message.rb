module Mail
  class Message
    attr_accessor :mandrill_template,
                  :mandrill_merge_vars

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
        @mandrill_merge_vars
      end
    end
  end
end
