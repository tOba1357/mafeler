class DiarySaveService
  attr_accessor :user, :diary, :udis, :udi_values

  def initialize(user, diary = nil)
    @user = user
    @diary = diary || @user.diaries.build
    @udis = @user.user_defined_items.index_by(&:name)
    @udi_values = []
    @errors = []
  end

  def save(params)
    Diary.transaction do
      @diary.attributes = diary_params(params)
      @diary.save!
      @udi_values = udi_params(params).map {|udi_name, value|
        udi = @udis[udi_name]
        if udi.blank?
          @errors.push('User Defined Item not found')
          raise ActiveRecord::RecordInvalid
        end
        UserDefinedItemValue.new(
          user_defined_item: udi,
          diary: @diary,
          value: value,
        )
      }
      UserDefinedItemValue.import @udi_values, on_duplicate_key_update: {conflict_target: [:diary_id, :user_defined_item_id], columns: [:value]}
    end
    true
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    false
  end

  def errors
    [].concat(@errors)
      .concat(@diary.errors.full_messages)
      .concat(@udi_values.map(&:errors).map(&:full_messages))
      .compact
  end

  def diary_params(params)
    params.require(:diary).permit(
      :date,
      :nap_hour,
      :appetite,
      :motivation,
      :condition,
      :note,
    )
  end

  def udi_params(params)
    keys = @udis.keys.map(&:to_sym)
    params.fetch(:udi_values, {}).permit(*keys).to_h
  end
end
