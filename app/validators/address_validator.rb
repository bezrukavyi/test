class AddressValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    options.keys.each do |inspection|
      if value !~ send(inspection) && object.errors.blank?
        object.errors.add(attribute, I18n.t("validators.address.#{inspection}"))
      end
    end
  end

  private

  def name
    /\A\w+(?>.*[-,\s])*\w+\z/
  end

  def zip
    /\A\d+(?>.*[-])*\d+\z/
  end

end