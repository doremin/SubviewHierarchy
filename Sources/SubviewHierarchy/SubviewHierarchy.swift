#if os(iOS)
import UIKit

/// A container for holding a hierarchy of UIViews constructed by `SubviewBuilder`.
public struct SubviewHierarchy {
    /// The array of `UIView` instances built by the result builder.
    public let views: [UIView]
    
    /// Initializes a new `SubviewHierarchy` with the given views.
    public init(views: [UIView]) {
        self.views = views
    }
}

/// A result builder that enables declarative construction of `UIView` hierarchies.
///
/// Supports single views, arrays of views, and conditional branches using `if/else`.
@resultBuilder
public struct SubviewBuilder {
    
    /// Handles single `UIView` expressions within the builder block.
    public static func buildExpression(_ expression: UIView) -> SubviewHierarchy {
        return SubviewHierarchy(views: [expression])
    }
    
    /// Handles array of `UIView`s within the builder block.
    public static func buildExpression(_ expression: [UIView]) -> SubviewHierarchy {
        return SubviewHierarchy(views: expression)
    }
    
    /// Combines multiple `SubviewHierarchy` components into a single hierarchy.
    public static func buildBlock(_ components: SubviewHierarchy...) -> SubviewHierarchy {
        return SubviewHierarchy(views: components.flatMap { $0.views })
    }
    
    /// Handles `if` conditional branches – `true` case.
    public static func buildEither(first component: SubviewHierarchy) -> SubviewHierarchy {
        return SubviewHierarchy(views: component.views)
    }
    
    /// Handles `if` conditional branches – `false` case.
    public static func buildEither(second component: SubviewHierarchy) -> SubviewHierarchy {
        return SubviewHierarchy(views: component.views)
    }
}

extension UIView {
    /// Enables SwiftUI-style declarative subview construction on any `UIView`.
    ///
    /// Usage:
    /// ```swift
    /// let view = UIView() {
    ///     UILabel()
    ///     UIButton()
    /// }
    /// ```
    /// Each child view is automatically added via `addSubview(_:)`.
    ///
    /// - Parameter builder: A closure that returns a `SubviewHierarchy` using the `@SubviewBuilder` DSL.
    /// - Returns: The same `UIView` instance after applying `addSubview`.
    @discardableResult
    public func callAsFunction(@SubviewBuilder _ builder: () -> SubviewHierarchy) -> UIView {
        builder().views.forEach { addSubview($0) }
        return self
    }
}
#endif
