require 'rails_helper'

describe UpdateOrder do

  let(:order_item) { create :order_item, quantity: 2 }
  let(:order) { order_item.order }
  subject { UpdateOrder.new({ order: order }) }

  context 'update order items' do
    let(:order_params) { { order_items_attributes: { id: order_item.id, quantity: 20 } } }
    let(:invalid_order_params) { { order_items_attributes: { id: order_item.id, quantity: -100 } } }

    before do
      allow(subject).to receive(:set_coupon)
    end

    context 'valid' do
      before do
        allow(subject).to receive(:order_params).and_return(order_params)
      end
      it 'set valid broadcast' do
        expect { subject.call }.to broadcast(:valid)
      end
      it 'change order items' do
        expect { subject.call }.to change{ order_item.reload.quantity }.from(2).to(20)
      end
    end

    it 'invalid' do
      allow(subject).to receive(:order_params).and_return(invalid_order_params)
      expect { subject.call }.to broadcast(:invalid)
    end
  end

  context 'update coupon' do
    before do
      allow(subject).to receive(:order_params).and_return({})
    end
    it 'set new coupon' do
      coupon = create :coupon
      allow(subject).to receive(:coupon_code).and_return(coupon.code)
      expect { subject.call }.to change{ order.reload.coupon }.from(nil).to(coupon)
    end
    it 'delete coupon' do
      coupon = create :coupon, order: order
      allow(subject).to receive(:coupon_code).and_return(nil)
      expect { subject.call }.to change{ order.reload.coupon }.from(coupon).to(nil)
    end
  end

end