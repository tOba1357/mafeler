# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FIXME: this implementation may be bad.
# when selection or constitutions id change, selection user selected is changed.
chinese_medicine_constitutions = [
  {
    label: '気虚',
    selections: [
      '顔色が悪い、白っぽい',
      '疲れやすく、いつもだるい',
      '食欲がない、少食である',
      'かぜをひきやすい',
      'トイレの回数が多い、夜もトイレに起きる',
      '下痢をしやすい、便がやわらかい',
      '声が小さく、ぼそぼそと話す',
      '息切れがする、動悸がする',
      '冷えを強く感じる',
      '舌がむくんで大きくなり、歯形がつく',
    ]
  },
  {
    label: '気滞',
    selections: [
      '怒りっぽい、すぐにカーッとなる',
      'いつも憂うつで、落ち込みやすい',
      'おなかが張って、痛い',
      '痛む場所が変わる、あちこち痛む',
      'げっぷやおならが多い',
      'せきが出たり、ぜんそくになったりする',
      '頭痛やめまいがする',
      'ためいきをつくことが多い',
      '月経不順になりやすい',
      '月経前や月経中に下腹部や乳房の張りがある',

    ]
  },
  {
    label: '血虚',
    selections: [
      '顔色が悪く、唇や舌が白っぽい',
      '立ちくらみやめまいがする',
      '動悸や不整脈がある',
      '目が乾いて疲れやすい、目がかすむ',
      'つめが白っぽくなり、すじが入る',
      'こむらがえりを起こしやすい',
      '手足がしびれることがある',
      '皮膚がかさかさしている',
      '月経困難症があり、痛むこともある',
      '月経の出血量が少なく、周期は遅れがち',
    ]
  },
  {
    label: '瘀血',
    selections: [
      '顔色や唇、歯茎が黒っぽく、目の下にクマができやすい',
      '吹き出物や湿疹がでやすい',
      '肌が荒れて、シミやそばかすが多い',
      '皮膚に細かい血管のすじが浮き出てくる',
      '肩こりなど、からだの一部がいつも痛い',
      '痛い部分を押すと、より痛くなる',
      '手足が冷える',
      '舌が紫色や濁った赤色になる',
      '月経困難症があり、強い痛みがある',
      '月経の出血量が多く、血のかたまりが出る',
    ]
  },
  {
    label: '痰湿',
    selections: [
      '全身がいつも重く、だるい',
      '顔や手足にむくみがある',
      '痰（たん）がからんでせきが多い',
      'いつも頭が重い',
      'めまいや吐き気がある',
      '太り気味、ぽちゃぽちゃした水太り',
      '水のような鼻水が出る',
      '便がやわらかく、下痢しやすい',
      '舌苔（ぜったい）がぶ厚い',
      '舌がむくんで大きくなり、歯形がつく',
    ]
  },
  {
    label: '陰虚',
    selections: [
      '顔のうち、頬は赤っぽい',
      '肌や髪が乾燥している',
      'のぼせがある',
      '声がかれて、からせきが出る',
      '目が乾き、おちくぼんでくる',
      '夕方から微熱が出る',
      '夜に手足がほてる',
      'のどが渇き、冷たい飲料水を好む',
      '便がかたく、便秘がちである',
      '舌は赤っぽく、ひび割れている',
    ]
  }
]

constitutions = chinese_medicine_constitutions.map.with_index do |constitution, index|
  ChineseMedicineConstitution.new(
    id: index + 1,
    label: constitution[:label]
  )
end

ChineseMedicineConstitution.import(
  constitutions,
  on_duplicate_key_update: {conflict_target: [:id], columns: [:label, :created_at, :updated_at]}
)

selections = chinese_medicine_constitutions.flat_map.with_index do |constitution|
  constitution_model = ChineseMedicineConstitution.find_by!(label: constitution[:label])
  constitution[:selections].map do |label|
    constitution_model.chinese_medicine_selections.build(label: label)
  end
end.map.with_index do |selection, index|
  selection.id = index + 1
  selection
end

ChineseMedicineSelection.import(
  selections,
  on_duplicate_key_update: {conflict_target: [:id], columns: [:label, :created_at, :updated_at]}
)
