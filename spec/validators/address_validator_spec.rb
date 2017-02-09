describe AddressValidator, type: :validator do

  with_model :MockAddress do
    table do |t|
      t.string :name
      t.string :zip
    end

    model do
      validates :name, address: { name: true }
      validates :zip, address: { zip: true }
    end
  end

  let(:address) { MockAddress.new(name: 'Simple address', zip: 123) }

  describe '#name' do

    context 'valid' do
      after do
        address.validate(:name)
        expect(address.errors.full_messages).to be_blank
      end

      it 'with -' do
        address.name = '343-2342'
      end
      it 'without ,' do
        address.name = '234, 234'
      end
      it 'with space' do
        address.name = '234 23423'
      end
    end

    it 'invalid by unsupport symbol' do
      address.name = 'sdasd#sd'
      address.validate(:name)
      expect(address.errors.full_messages).to include('Name ' + I18n.t('validators.address.name'))
    end

  end

  describe '#zip' do
    it 'valid with -' do
      address.zip = '234-234'
      address.validate(:zip)
      expect(address.errors.full_messages).to be_blank
    end
    it 'invalid with ,' do
      address.zip = '234,234'
      address.validate(:zip)
      expect(address.errors.full_messages).to include('Zip ' + I18n.t('validators.address.zip'))
    end
  end

end
