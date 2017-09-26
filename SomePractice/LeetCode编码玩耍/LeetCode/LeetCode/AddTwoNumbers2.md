#Add Two Numbers2
### 题目：
 You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
 
 You may assume the two numbers do not contain any leading zero, except the number 0 itself.
 
 Follow up:
 What if you cannot modify the input lists? In other words, reversing the lists is not allowed.
 
 Example:
 
 Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 8 -> 0 -> 7
 
### 中文题目：
给出两个不为空的链表表示的非负数字。最大的一位是在第一个，其后一个节点保存一位数字。把两个数字加起来并将结果返回成一个链表。
你可以假设这两个数没有开头的0，除了0本身

接下来：
如果你不能修改输入链表？换句话说，你不能反转链表
例子：

输入: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
输出: 7 -> 8 -> 0 -> 7

### 解题思路：
反转链表，然后按照Add Two Numbers中的算法按位相加，得出的结果再反转链表则得到结果。

### 代码展示：

链表节点

```
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}
```

反转链表函数

```
/*
     函数：
     1、反转链表函数
     2、之前面的相加函数
     */
    /// 反转单链表：时间复杂度O（n），空间复杂度O（1）
    func reverseList(l : ListNode) -> ListNode {
        // 思路：每次将头节点放到链表最后
        let newHead : ListNode? = ListNode(-1)
        var curr : ListNode? = l
        var pre : ListNode? = l
        newHead?.next = l
        
        // O(n) n为List长度
        while curr != nil {
            pre = curr // pre是最后一个节点
            curr = curr?.next
        }
        
        // O(n) n为List长度
        while newHead?.next !== pre {
            let node = newHead?.next
            newHead?.next = newHead?.next?.next // 删除第一个节点
            node?.next = pre?.next// 将node插入到pre的后面
            pre?.next = node
        }
        return (newHead?.next)!
    }
```

反转后的相加函数

```
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var finalSum : ListNode?
        let q = reverseList(l: l1!)
        let p = reverseList(l: l2!)
        
        finalSum = AddTwoNumbers().finalAddTwoNumbers(q, p)
        return reverseList(l: finalSum!)
    }

```

一般的两个链表相加，第一位是个位

```
func finalAddTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        /*
         算法时间复杂度为O(max(m,n))
         空间复杂度为O(max(m,n)) 因为最终的结果长度为max(m,n)
         其中m和n为两个数的长度
         */
        var finalResult : ListNode?
        var curr : ListNode?
        var p = l1
        var q = l2
        var carry : Int = 0
        while p != nil || q != nil {
            let a = p == nil ? 0 : p?.val ?? 0
            let b = q == nil ? 0 : q?.val ?? 0
            var sum = carry + a + b
            carry = sum / 10
            sum = sum % 10
            if finalResult == nil{
                finalResult = ListNode(sum)
                curr = finalResult
            }else {
                curr?.next = ListNode(sum)
                curr = curr?.next!
            }
            if p != nil { p = p?.next }
            if q != nil { q = q?.next }
        }
        if carry > 0 { curr?.next = ListNode(1) }
        return finalResult
    }
```

### Follow up:
What if you cannot modify the input lists? In other words, reversing the lists is not allowed.（如果不能反转呢？）
### 解题思路：
1. 补0，给位数少的数的链表头补0
2. 相加，使用一个tag来记录是否有进位，使用一个相同位数的链表来存进位信息。
3. 递归调用自己直到进位tag为false

### 具体代码有待实施


