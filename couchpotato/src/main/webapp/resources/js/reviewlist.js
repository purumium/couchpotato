 $(document).ready(function() {
    $('.review-slider').each(function() {
        const $slider = $(this);
        const $track = $slider.find('.review-track');
        const $slides = $track.children();
        const slideCount = $slides.length;
        const slideWidth = $slides.first().outerWidth(true);
        const visibleSlides = 4; // 한 번에 보여줄 슬라이드 개수
        
        let currentIndex = 0;

        function updateButtons() {
            $slider.find('.prev-slide').prop('disabled', currentIndex === 0);
            $slider.find('.next-slide').prop('disabled', currentIndex >= slideCount - visibleSlides);
        }

        $slider.find('.prev-slide').click(function() {
            if (currentIndex > 0) {
                currentIndex--;
                $track.css('transform', 'translateX(' + (-currentIndex * slideWidth) + 'px)');
                updateButtons();
            }
        });

        $slider.find('.next-slide').click(function() {
            if (currentIndex < slideCount - visibleSlides) {
                currentIndex++;
                $track.css('transform', 'translateX(' + (-currentIndex * slideWidth) + 'px)');
                updateButtons();
            }
        });

        updateButtons();
    });
});