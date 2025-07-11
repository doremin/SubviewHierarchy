import Testing
@testable import SubviewHierarchy

import UIKit

final class CustomView: UIView { }

@MainActor
struct SubviewHierarchyTests {

    @Test
    func testSimpleSubviewHierarchy() {
        // Given
        let container = UIView()
        let label = UILabel()
        let button = UIButton()
        
        // When
        container {
            label
            button
        }
        
        // Then
        #expect(container.subviews.count == 2)
        #expect(container.subviews.first === label)
        #expect(container.subviews.last === button)
    }
    
    @Test
    func testNestedSubviewHierarchy() {
        // Given
        let container = UIView()
        let inner = UIView()
        let label = UILabel()
        
        // When
        container {
            inner {
                label
            }
        }
        
        // Then
        #expect(container.subviews.count == 1)
        #expect(container.subviews.first === inner)
        #expect(inner.subviews.count == 1)
        #expect(inner.subviews.first === label)
    }
    
    @Test
    func testMultipleLayersDeep() {
        // Given
        let root = UIView()
        let a = UIView()
        let b = UIView()
        let c = UIView()
        let d = UIView()
        
        // When
        root {
            a {
                b {
                    c {
                        d
                    }
                }
            }
        }
        
        // Then
        #expect(root.subviews == [a])
        #expect(a.subviews == [b])
        #expect(b.subviews == [c])
        #expect(c.subviews == [d])
        #expect(d.subviews.isEmpty)
    }
    
    @Test
    func testArraySubviewInjection() {
        // Given
        let root = UIView()
        let a = UIView()
        let b = UIView()
        let views = [a, b]
        
        // When
        root {
            views
        }
        
        // Then
        #expect(root.subviews.count == 2)
        #expect(root.subviews.first === a)
        #expect(root.subviews[1] === b)
    }
    
    @Test
    func testCreateViewOnClosure() {
        // Given
        let root = UIView()
        let b = UIView()
        
        // When
        root {
            let c: UIView = {
                let view = UIView()
                view.backgroundColor = .red
                return view
            }()
            
            c {
                b
            }
        }
        
        // Then
        let c = root.subviews.first!
        #expect(root.subviews.first == c)
        #expect(c.backgroundColor == .red)
        #expect(c.subviews.first == b)
    }
    
    @Test
    func testEmptyHierarchy() {
        // Given
        let root = UIView()
        
        // When
        root {
            
        }
        
        // Then
        #expect(root.subviews.isEmpty)
    }
    
    @Test
    func testCustomView() {
        // Given
        let root = CustomView()
        let label = UILabel()
        
        // When
        root {
            label
        }
        
        // Then
        #expect(root.subviews.first == label)
    }
    
    @Test("Conditional Subview", arguments: [
        true,
        false
    ])
    func testConditional(isAddA: Bool) {
        // Given
        let root = UIView()
        let a = UIView()
        let b = UIView()

        // When
        root {
            if isAddA {
                a
            } else {
                b
            }
        }
        
        // Then
        #expect(root.subviews.count == 1)
        if isAddA {
            #expect(root.subviews.first === a)
        } else {
            #expect(root.subviews.first === b)
        }
    }
    
    @Test("Various UIView Subclasses", arguments: [
        UILabel(),
        UIButton(),
        UIScrollView(),
        UITableView(),
        UIImageView(),
        UITextField(),
        UITextView(),
        UIActivityIndicatorView()
    ])
    func testVariousUIViewSubclasses(_ view: UIView) {
        // Given
        let root = UIView()
        
        // When
        root {
            view
        }
        
        // Then
        #expect(root.subviews.first === view)
    }
    
    @Test
    func testArrayInjection() {
        // Given
        let root = UIView()
        let buttons = (0 ..< 5).map { _ in UIButton() }
        
        // When
        root {
            buttons
        }
        
        // Then
        #expect(root.subviews.count == 5)
        #expect(root.subviews == buttons)
    }
    
    @Test
    func testReparentingView() {
        // Given
        let parent1 = UIView()
        let parent2 = UIView()
        let label = UILabel()
        
        // When {
        parent1 {
            label
        }
        
        parent2 {
            label
        }
        
        // Then
        #expect(parent1.subviews.isEmpty)
        #expect(parent2.subviews.first == label)
    }
    
    @Test
    func testDuplicateViewInstance() {
        // Given
        let root = UIView()
        let label = UILabel()
        
        // When
        root {
            label
            label
        }
        
        // Then
        #expect(root.subviews.count == 1)
        #expect(root.subviews[0] === label)
    }
}
