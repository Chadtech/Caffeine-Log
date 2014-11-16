# ######

User = new Schema
  name:
    type: string
  caffeineIntake:
    type: [Schema.Types.ObjectId]
    ref: 'Instances'

Instance = new Schema
  amount:
    type: number
  unit:
    type: string
  date:
    type: date
    default: date.now()

q = User.findById _id: '1234567891235678'
q.populate('caffeineIntake')

# ##########

module.exports = fission.model
  url: 'rest api dot com'