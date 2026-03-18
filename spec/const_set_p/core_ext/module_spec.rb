# frozen_string_literal: true

require "securerandom"

RSpec.describe Module do
  describe "#const_set_p" do
    subject { mod.const_set_p(name, value) }

    let(:mod) do
      Module.new do
        const_set(:C, Class.new)
        const_set(:S, "string")
      end
    end
    let(:value) { SecureRandom.uuid }

    context 'when the name does not contain "::"' do
      let(:name) { "N" }

      it "defines M::N and it returns value" do
        subject
        expect(mod::N).to eq value
      end
    end

    context 'when the name contains "::"' do
      context "when the name does not contain the name of a pre-defined constant" do
        let(:name) { "N::O" }

        it "defines M::N and M::N::O and it returns Module" do
          subject
          expect(mod::N).to be_a Module # rubocop:disable RSpec/DescribedClass
        end

        it "defines M::N::O and it returns value" do
          subject
          expect(mod::N::O).to eq value
        end
      end

      context "when the name contains the name of a pre-defined constant" do
        context "when the type of constant is a Class or Module" do
          let(:name) { "C::D" }

          it "does not replace M::C" do
            expect { subject }.not_to(change { mod::C })
          end

          it "defines M::C::D and it returns value" do
            subject
            expect(mod::C::D).to eq value
          end
        end

        context "when the type of constant is not a Class or Module" do
          let(:name) { "S::T" }

          it { expect { subject }.to raise_error(NameError) }
        end
      end
    end
  end
end
