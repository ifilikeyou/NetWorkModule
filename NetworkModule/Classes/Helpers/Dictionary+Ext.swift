/// 使用帮助 参考 Reference文件夹



import Foundation

/// 字典拓展 + 方法
public func + <KeyType, ValueType> (left: [KeyType: ValueType], right: [KeyType: ValueType]) -> [KeyType: ValueType] {
  var out = left

  for (k, v) in right {
    out.updateValue(v, forKey: k)
  }

  return out
}
