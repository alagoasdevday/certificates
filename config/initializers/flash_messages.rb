# frozen_string_literal: true

module ActionController
  module Flash
    def render(*args)
      options = args.last.is_a?(Hash) ? args.last : {}

      flash_messages(options)

      super(*args)
    end

    private

    def flash_messages(options)
      flash_alert(options)
      flash_notice(options)
      flash_other(options)
    end

    def flash_alert(options)
      alert = options.delete(:alert)
      return unless alert

      flash[:alert] = alert
    end

    def flash_notice(options)
      notice = options.delete(:notice)
      return unless notice

      flash[:notice] = notice
    end

    def flash_other(options)
      other = options.delete(:flash)
      return unless other

      flash.update(other)
    end
  end
end
