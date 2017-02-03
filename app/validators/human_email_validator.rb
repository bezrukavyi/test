class HumanEmailValidator < ActiveModel::EachValidator

  SUPP_SYMBOLS = SpecSymbolsValidator::INSPECTION
  DOMAIN = /@[\w\-.]+\.[a-z]+/

  INSPECTIONS = [:base_regexp, :dot_regexp, :symbols_regexp]

  def validate_each(object, attribute, value)
    INSPECTIONS.each do |inspection|
      if value.present? && value !~ send(inspection)
        object.errors.add(attribute, I18n.t("validators.human.email.#{inspection}"))
      end
    end
  end

  private

  def base_regexp
    /\A.+#{DOMAIN}\z/
  end

  def symbols_regexp
    /\A#{SUPP_SYMBOLS}#{DOMAIN}\z/
  end

  def dot_regexp
    /\A(?!\.)+.*(?<!\.)+#{DOMAIN}\z/
  end

end